From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that
	needs	acpi_sleep=nonvs
Date: Tue, 26 Oct 2010 14:19:48 +0100
Message-ID: <20101026131948.GA9221__4744.63843643225$1288099337$gmane$org@srcf.ucam.org>
References: <201010172101.21576.rjw@sisk.pl>
	<alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
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

On Mon, Oct 25, 2010 at 08:14:42PM -0400, Len Brown wrote:
> Rather than a black list of machines that can not survive saving NVS,
> I wonder how long a white list of machines requiring NVS save would be?

Windows saves the NVS area in my testing. Either there's something that 
indicates the choices of one behaviour over the other, or the machines 
that are broken by NVS saving are actually tripping some other bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
