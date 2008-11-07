From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
 region at startup (rev. 2)
Date: Thu, 06 Nov 2008 21:24:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062123100.3106__6548.18531261316$1226024891$gmane$org@localhost.localdomain>
References: <200810262048.23468.rjw@sisk.pl> <200810262054.24929.rjw@sisk.pl>
	<200810310102.42041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810310102.42041.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> Please replace this patch with the appended one.
> 
> I have verified that we are supposed to save/restore the NVS area in the EFI
> case too.

done.
i've also rebased the suspend branch on top of latest linus.

thanks,
-Len
