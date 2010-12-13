From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Wrong commit in the ACPI release branch
Date: Mon, 13 Dec 2010 22:09:16 +0100
Message-ID: <201012132209.17173.rjw__27531.2249701985$1292274840$gmane$org@sisk.pl>
References: <201012112329.35080.rjw@sisk.pl>
	<4D05E1E502000078000277B6@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D05E1E502000078000277B6@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 13, 2010, Jan Beulich wrote:
> >>> On 11.12.10 at 23:29, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > The following commit:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h 
> > =091aad6af4ab29af693ced5d6970ceee9d5981c8
> > 
> > (ACPI: eliminate unused variable warning for !ACPI_SLEEP)
> > is actually wrong, because it's going to break compilation for
> > (!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).
> 
> How would this break compilation in *any* configuration? The
> variable definition got moved into an #ifdef the #else of which
> has
> 
> #define acpi_target_sleep_state	ACPI_STATE_S0

OK, I seem to haven't looked at the patch carefully enough, sorry for the
noise.

Rafael
