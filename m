From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that
	needs acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 20:49:21 +0200
Message-ID: <201010262049.21424.rjw__20751.8172836446$1288119316$gmane$org@sisk.pl>
References: <201010172101.21576.rjw@sisk.pl>
	<alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
	<20101026131948.GA9221@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101026131948.GA9221@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 26, 2010, Matthew Garrett wrote:
> On Mon, Oct 25, 2010 at 08:14:42PM -0400, Len Brown wrote:
> > Rather than a black list of machines that can not survive saving NVS,
> > I wonder how long a white list of machines requiring NVS save would be?
> 
> Windows saves the NVS area in my testing. Either there's something that 
> indicates the choices of one behaviour over the other, or the machines 
> that are broken by NVS saving are actually tripping some other bug.

Since we're claiming Windows compatibility through _OSI, we should follow
Windows except for on machines that are blacklisted as not being
Windows-compatible.

Thanks,
Rafael
