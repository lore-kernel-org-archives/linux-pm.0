From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/6] ACPI / PM: Do not switch interrupts
 off/on in acpi_hibernation_enter()
Date: Fri, 4 Mar 2011 16:39:07 +0100
Message-ID: <20110304153907.GH1358__19570.1806493618$1299254322$gmane$org@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl> <201102072322.47041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072322.47041.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2011-02-07 23:22:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The function acpi_hibernation_enter() is always called with
> interrupts off, so it doesn't need to switch them off and on.

ack... and maybe comment?
							       Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
