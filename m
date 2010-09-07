From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Tue, 7 Sep 2010 13:54:31 +0200
Message-ID: <201009071354.32149.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201009021633.22869.stephan.diestelhorst@amd.com> <AANLkTi==kpbcJQ9E_MMfs9Ohu_O4vNsf8T7NK1z+iAwn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <AANLkTi==kpbcJQ9E_MMfs9Ohu_O4vNsf8T7NK1z+iAwn@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 02 September 2010, 22:52:56 I wrote:
> On Thu, Sep 2, 2010 at 4:33 PM, Stephan Diestelhorst
> <stephan.diestelhorst@amd.com> wrote:
> > On Thursday 02 September 2010, 12:02:49 Tejun Heo wrote:
> >> For some mysterious reason, certain hardware reacts badly to usual EH
> >> actions while the system is going for suspend.  As the devices won't
> >> be needed until the system is resumed, ask EH to skip usual autopsy
> >> and recovery and proceed directly to suspend.
> >
> > Thanks Tejun for this patch. Will test in a second!
> 
> Applied, compiled and worked for the 5 iterations I managed to test it.
> Much better than your previous patch, thanks a lot! I'd give it some more spins
> tomorrow, though.

Alright, I have tested for more than 20 iterations now. It works
great! Thanks for the fix!

Are there any plans for upstream inclusion?

Thanks,
  Stephan


-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

