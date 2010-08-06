From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend to RAM
Date: Fri, 6 Aug 2010 11:04:11 +0200
Message-ID: <201008061104.12574.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008060830.50889.stephan.diestelhorst@amd.com> <4C5BB472.5000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C5BB472.5000207@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

HI,

On Friday 06 August 2010, 09:06:26 Tejun Heo wrote:
> On 08/06/2010 08:30 AM, Stephan Diestelhorst wrote:
> > On Thursday 05 August 2010, 18:08:02 Tejun Heo wrote:
> >> Can you please try the following patch and see whether the problem
> >> goes away?
> > <snip>
> > 
> > to which revision does the patch apply? I didn't get it to apply
> > cleanly to Linus' kernel HEAD or the 2.6.34 stable tag. Maybe I am
> > missing something, since I am a git-n00b (use Mercurial all the time)?
> 
> It applies cleanly to v2.6.35.

Arrrgh. My "great" company Exchange mail server thought it was a good
idea to mess with the white-space of the mail. That's why the patch did
not apply. Compiling and testing now, sorry.

Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
