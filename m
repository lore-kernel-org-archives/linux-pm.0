From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 14:02:44 +0200
Message-ID: <200608091402.44749.rjw@sisk.pl>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl>
	<20060809114628.GR3308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060809114628.GR3308@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:46, Pavel Machek wrote:
> > Introduce the memory bitmap data structure and make swsusp use in the s=
uspend
> > phase.
]--snip--[
> =

> Maybe that bitmap code should go to kernel/power/bitmaps.c or
> something?

Then we'll also need another header or put the definitions in power.h, but
they will only be used by the code in snapshot.c anyway.  Apart from this,
the "bitmap" functions refer to alloc_image_page() etc. that are internal
to snapshot.c.

I thought it would be better to add this code to snapshot.c, because it's n=
ot
needed anywhere else and the separation of it would increase the overall
complexity for a little real gain.

> > +static inline void bm_position_reset_chunk(struct memory_bitmap *bm)
> > +{
> > +	bm->cur.chunk =3D 0;
> > +	bm->cur.bit =3D -1;
> > +}
> > +
> > +static void bm_position_reset(struct memory_bitmap *bm)
> > +{
> > +	struct zone_bitmap *zone_bm;
> > +
> > +	zone_bm =3D bm->zone_bm_list;
> > +	bm->cur.zone_bm =3D zone_bm;
> > +	bm->cur.block =3D zone_bm->bm_blocks;
> > +	bm_position_reset_chunk(bm);
> > +}
> > +
> > +static void free_memory_bm(struct memory_bitmap *bm, int
> > clear_nosave_free);
> =

> All your other functions use bm_XXX, this is XXX_bm. Well, you are
> mixing it rather freely..

OK, I'll change that to XXX_bm.

> > +/**
> > + *	memory_bm_set_bit - set the bit in the bitmap @bm that corresponds
> > + *	to given pfn.  The cur_zone_bm member of @bm and the cur_block memb=
er
> > + *	of @bm->cur_zone_bm are updated.
> > + *
> > + *	If the bit cannot be set, the function returns -EINVAL .
> > + */
> > +
> > +static int
> > +memory_bm_set_bit(struct memory_bitmap *bm, unsigned long pfn)
> > +{
> > +	struct zone_bitmap *zone_bm;
> > +	struct bm_block *bb;
> > +
> > +	/* Check if the pfn is from the current zone */
> > +	zone_bm =3D bm->cur.zone_bm;
> > +	if (pfn < zone_bm->start_pfn || pfn >=3D zone_bm->end_pfn) {
> > +		zone_bm =3D bm->zone_bm_list;
> > +		/* We don't assume that the zones are sorted by pfns */
> > +		while (pfn < zone_bm->start_pfn || pfn >=3D zone_bm->end_pfn) {
> > +			zone_bm =3D zone_bm->next;
> > +			if (unlikely(!zone_bm))
> > +				return -EINVAL;
> > +		}
> > +		bm->cur.zone_bm =3D zone_bm;
> > +	}
> > +	/* Check if the pfn corresponds to the current bitmap block */
> > +	bb =3D zone_bm->cur_block;
> > +	if (pfn < bb->start_pfn)
> > +		bb =3D zone_bm->bm_blocks;
> > +
> > +	while (pfn >=3D bb->end_pfn) {
> > +		bb =3D bb->next;
> > +		if (unlikely(!bb))
> > +			return -EINVAL;
> > +	}
> > +	zone_bm->cur_block =3D bb;
> > +	pfn -=3D bb->start_pfn;
> > +	set_bit(pfn % BM_BITS_PER_CHUNK, bb->data + pfn / BM_BITS_PER_CHUNK);
> > +	return 0;
> > +}
> =

> It seems like this will not really introduce O(n^2) behaviour, since
> you are starting from last position each time?

Exactly.

> You have my ACK here,

Thanks. :-)

> but maybe it should go _after_ 4/5 and 5/5? Those are simple cleanups, th=
is
> has break-something-potential and should rest in -mm for a while.

OK, I'll redo the series this way.

Rafael
