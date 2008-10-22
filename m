From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] Hibernate: Handle ACPI NVS memory as
	required by the spec
Date: Wed, 22 Oct 2008 22:49:20 +0200
Message-ID: <200810222249.20629.rjw__7055.77234407446$1224709055$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

I have recently tried to rebase the Zhang Rui's patches making the Linux
hibernation code handle the ACPI NVS memory as required by the spec, but
I found that they didn't work on x86_64 boxes where the NVS region was located
behind the last usable PFN.  Also, I decided to put the memory management part
into the hibernation core rather than into drivers/acpi/sleep/main.c .

As a result, I have obtained the following patch series.  Please review and if
it looks good, please queue in the 'suspend' branch as .29 material.

Thanks,
Rafael
