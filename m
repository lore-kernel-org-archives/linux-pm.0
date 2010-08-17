From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend to RAM
Date: Tue, 17 Aug 2010 12:29:28 +0200
Message-ID: <201008171229.28917.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008171132.56431.stephan.diestelhorst@amd.com> <4C6A6145.7020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C6A6145.7020707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 17 August 2010 12:15:33 Tejun Heo wrote:
> On 08/17/2010 11:32 AM, Stephan Diestelhorst wrote:
> > Indeed. Like I said, I have similar issues on a another Samsung HDD in
> > an AMD system. I have not yet got around to try the fix there, but I
> > suspect it is the same thing.
> > 
> > I have attached the full /var/log/messages and /var/log/kern.log with
> > multiple suspend-to-ram runs and the last one failing.
> 
> Hmm... are you sure the patch is applied?  There's no debug message
> outputs in the log which the patch added.

...

Let me get back to you. :-/

Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

