From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 acpi: on wakeup,
	ljmp directly after writing CR0.PE
Date: Sun, 26 Oct 2008 21:38:15 +0100
Message-ID: <200810262138.15669.rjw__43535.5376372629$1225053345$gmane$org@sisk.pl>
References: <200810262038.51149.rjw@sisk.pl> <4904D30C.7080200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4904D30C.7080200@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 26 of October 2008, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > Ingo, Peter,
> > 
> > I have this patch in my queue, is it necessary or should I drop it?
> > 
> 
> It's unclear if it's necessary, but I think it's more compliant and we 
> should do it.

OK, then.

Ingo, please queue. :-)

Thanks,
Rafael
