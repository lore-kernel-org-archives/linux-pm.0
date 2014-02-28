From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 14/46] kernel: Move prototype declaration to header
 file kernel/power/power.h
Date: Fri, 28 Feb 2014 14:21:09 +0100
Message-ID: <20140228132109.GB16401@amd.pavel.ucw.cz>
References: <7b4a60c74ced00e0d65c38488f20dc4bd69f0dd2.1393493276.git.rashika.kheria@gmail.com>
 <620346a9abff597545a6249d0d8c4adba8f1a1d9.1393493276.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48219 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaB1NVL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2014 08:21:11 -0500
Content-Disposition: inline
In-Reply-To: <620346a9abff597545a6249d0d8c4adba8f1a1d9.1393493276.git.rashika.kheria@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, josh@joshtriplett.org

On Thu 2014-02-27 17:13:53, Rashika Kheria wrote:
> Move prototype declaration of function to header file
> kernel/power/power.h
> because it is used by more than one file.
>=20
> This eliminates the following warning in kernel/power/snapshot.c:
> kernel/power/snapshot.c:1588:16: warning: no previous prototype for =E2=
=80=98swsusp_save=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
