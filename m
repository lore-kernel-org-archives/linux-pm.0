From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 acpi: on wakeup,
	ljmp directly after writing CR0.PE
Date: Sun, 26 Oct 2008 13:29:00 -0700
Message-ID: <4904D30C.7080200__45106.8499628038$1225053098$gmane$org@zytor.com>
References: <200810262038.51149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810262038.51149.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> Ingo, Peter,
> 
> I have this patch in my queue, is it necessary or should I drop it?
> 

It's unclear if it's necessary, but I think it's more compliant and we 
should do it.

	-hpa
