From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
Date: Thu, 18 Oct 2018 14:00:40 +0200
Message-ID: <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de>
 <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com> <20181017072020.GD23407@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017072020.GD23407@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
List-Id: linux-pm@vger.kernel.org

Le mer. 17 oct. 2018 =C3=A0 09:20, Christoph Hellwig <hch@lst.de> a =C3=A9c=
rit :
>
> On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:
> > Le sam. 13 oct. 2018 =C3=A0 17:18, Christoph Hellwig <hch@lst.de> a =C3=
=A9crit :
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mas=
k.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>
> Can you pick it up through the media tree?

No but Mauros or Hans (in CC) can add it.
