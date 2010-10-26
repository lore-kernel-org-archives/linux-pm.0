From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that
	needs	acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 20:23:07 +0100
Message-ID: <20101026192307.GB17880__47449.9114825905$1288121103$gmane$org@srcf.ucam.org>
References: <201010172101.21576.rjw@sisk.pl>
	<alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
	<20101026131948.GA9221@srcf.ucam.org>
	<201010262049.21424.rjw@sisk.pl>
	<alpine.LFD.2.00.1010261519490.11689@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010261519490.11689@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 26, 2010 at 03:21:15PM -0400, Len Brown wrote:
> > Windows-compatible.
> 
> Matthew,
> Exactly what version of Windows did you test to be saving NVS?
> Is it possible that different versions of Windows behave differently?

XP. It's certainly possible that later versions behave differently - 
I'll have to go back and check the original machine that had this 
problem to see which _OSI calls it makes. It may be that querying Vista 
or 7 disables this functionality.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
