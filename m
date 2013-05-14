From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] hibernate: Correct documentation
Date: Tue, 14 May 2013 01:34:31 -0500
Message-ID: <1368513271.18069.235@driftwood>
References: <136862945.66DBfZPmr6@vostro.rjw.lan>
	<1368446403-4896-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	Format=Flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49804 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab3ENGee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 02:34:34 -0400
Received: by mail-ia0-f174.google.com with SMTP id j3so216192iae.33
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2013 23:34:34 -0700 (PDT)
In-Reply-To: <1368446403-4896-1-git-send-email-bp@alien8.de> (from
	bp@alien8.de on Mon May 13 07:00:03 2013)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, paulmck@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, =?iso-8859-1?b?Qmr4cm4=?= Mork <bjorn@mork.no>

On 05/13/2013 07:00:03 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> Correct the meaning of PM_HIBERNATION_PREPARE in the docs, as per
> Rafael.
>=20
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Bj=F8rn Mork <bjorn@mork.no>
> Link: http://lkml.kernel.org/r/20130512162717.GA6305@pd.tnic
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  Documentation/power/notifiers.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/power/notifiers.txt =20
> b/Documentation/power/notifiers.txt
> index c2a4a346c0d9..a81fa254303d 100644
> --- a/Documentation/power/notifiers.txt
> +++ b/Documentation/power/notifiers.txt
> @@ -15,8 +15,10 @@ A suspend/hibernation notifier may be used for =20
> this purpose.
>  The subsystems or drivers having such needs can register suspend =20
> notifiers that
>  will be called upon the following events by the PM core:
>=20
> -PM_HIBERNATION_PREPARE	The system is going to hibernate or =20
> suspend, tasks will
> -			be frozen immediately.
> +PM_HIBERNATION_PREPARE	The system is going to hibernate, tasks =20
> will be frozen
> +			immediately. This is different from =20
> PM_SUSPEND_PREPARE
> +			below because here we do additional work =20
> between notifiers
> +			and drivers freezing.

Additional work such as...?

Rob