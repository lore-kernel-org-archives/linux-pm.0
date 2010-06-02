From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 20:26:32 -0700
Message-ID: <CA1BBBBC9359F04AA639128AC0D5D1E9692AAF4F__956.88949008963$1275491834$gmane$org@orsmsx502.amr.corp.intel.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<CA1BBBBC9359F04AA639128AC0D5D1E9692AAF29@orsmsx502.amr.corp.intel.com>
	<AANLkTinsgmHh7iLhESPXiTkoW9SL4H8E92-7bARpDxNX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinsgmHh7iLhESPXiTkoW9SL4H8E92-7bARpDxNX@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Neil Brown <neilb@suse.de>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org


>-----Original Message-----
>From: Arve Hj=F8nnev=E5g [mailto:arve@android.com]
>Sent: Tuesday, June 01, 2010 8:15 PM
>To: Gross, Mark
>Cc: James Bottomley; Rafael J. Wysocki; Matthew Garrett; Thomas Gleixner;
>Peter Zijlstra; tytso@mit.edu; LKML; Florian Mickler; Linux PM; Linux OMAP
>Mailing List; felipe.balbi@nokia.com; Alan Cox; Alan Stern; Neil Brown
>Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
>
>2010/6/1 Gross, Mark <mark.gross@intel.com>:
>...
>>>4. It would be useful to change pm_qos_add_request to not allocate
>>>anything so can add constraints from init functions that currently
>>>cannot fail.
>> [mtg: ] I'm not sure how to do this but I agree it would be good. =A0I
>guess we could have a block of pm_qos requests pre-allocated statically and
>re-use them. =A0In practice there will not be more than a handful of reque=
sts
>ever. =A0Dynamic allocation does seem like a bit of a waste.
>
>The calling code will have to store a pointer to your structure
>anyway, you may as well have them provide the whole structure.
[mtg: ] duh!  You are right.  Make the caller's hold the structure.  Its be=
en a long day.  That would be easy todo.

--gmross
