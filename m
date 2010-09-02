From: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM
	during suspend to RAM
Date: Thu, 2 Sep 2010 16:31:59 +0200
Message-ID: <201009021632.00699.stephan.diestelhorst@amd.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com>
	<201008262024.35551.rjw@sisk.pl> <201008280135.39005.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008280135.39005.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 28 August 2010, 01:35:38 Rafael J. Wysocki wrote:
> I reproduced the problem with the Tejun's patch applied, so I'm now quite
> sure the problem is related to the suspend of controller ports (which is done
> by scheduling SCSI error handling on the controller).
> 
> Anyway, below is a new version of my patch that plays a bit nicer with
> the resume code.  Can you please check if it still fixes the problem for you?

Applied to 2.6.35.3 and tested. Works perfectly fine (> 10 s2ram
cycles under heavy I/O load).

Many thanks,
  Stephan

-- 
Stephan Diestelhorst, AMD Operating System Research Center
stephan.diestelhorst@amd.com, Tel. +49 (0)351 448 356 719

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
