From: Maciej Matraszek <m.matraszek@samsung.com>
Subject: Re: [PATCH] PM / Domains: add debugfs listing of struct
 generic_pm_domain-s
Date: Thu, 11 Sep 2014 18:52:48 +0200
Message-ID: <1410454368.8852.13.camel@AMDC723>
References: <1410348536-15201-1-git-send-email-m.matraszek@samsung.com>
 <20140910191825.GA7996@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140910191825.GA7996@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Al!

On =C5=9Bro, 2014-09-10 at 20:18 +0100, Al Viro wrote:
> On Wed, Sep 10, 2014 at 01:28:56PM +0200, Maciej Matraszek wrote:
>=20
> > +static int pm_genpd_summary_open(struct inode *inode, struct file =
*file)
> > +{
> > +	return single_open(file, pm_genpd_summary_show, inode->i_private)=
;
> 							^^^^^^^^^^^^^^^^
> 							what for?
>=20
> Where in pm_genpd_summary_show() are you using ->private?

Nowhere, thanks! (Just a mindless copy-paste from clk_summary_open().)

Regards,
--=20
Maciej Matraszek
Samsung R&D Institute Poland
Samsung Electronics
