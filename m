From: Mason <slash.tmp@free.fr>
Subject: Re: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Date: Thu, 29 Dec 2016 15:27:12 +0100
Message-ID: <4dc90086-180d-df9a-297f-6f4680de7bdd@free.fr>
References: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
 <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
 <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
 <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:19093 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbcL2O1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Dec 2016 09:27:54 -0500
In-Reply-To: <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
Content-Language: 
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>
Cc: Yu Chen <yu.chen.surf@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Thomas Gambier <thomas_gambier@sigmadesigns.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@kernel.org>, Mark Brown <broonie@kernel.org>

On Thu, Dec 15, 2016 at 11:18 PM, Mason wrote:

> However, while Linux successfully starts the secondary cores when
> the system first boots, it fails when the system resumes from "S3".

Oh boy...

Turns out the firmware was, in fact, (upon resume) stomping over parts
of the Linux memory image in RAM, triggering all kinds of "interesting"
nasal demons when Linux ran (or, more accurately, limped).

The guilty party will be properly dealt with. (Where's my foam bat?)

Regards.

