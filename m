From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86, irq: Fix regression caused by commit b568b8601f05
Date: Mon, 16 Feb 2015 20:36:37 +0100
Message-ID: <20150216193637.GA13497@amd>
References: <1424039150-4115-1-git-send-email-syrjala@sci.fi>
 <1424052673-22974-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51699 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbbBPTgl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 14:36:41 -0500
Content-Disposition: inline
In-Reply-To: <1424052673-22974-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Sander Eikelenboom <linux@eikelenboom.it>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2015-02-16 10:11:13, Jiang Liu wrote:
> Commit b568b8601f05 ("Treat SCI interrupt as normal GSI interrupt")
> accidently removes support of legacy PIC interrupt when fixing a

accidentaly?

> regression for Xen, which causes a nasty regression on HP/Compaq
> nc6000 where we fail to register the ACPI interrupt, and thus
> lose eg. thermal notifications leading a potentially overheated
> machine.
>=20
> So reintroduce support of legacy PIC based ACPI SCI interrupt.
>=20
> Reported-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
