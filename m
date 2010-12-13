From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: Wrong commit in the ACPI release branch
Date: Mon, 13 Dec 2010 08:05:41 +0000
Message-ID: <4D05E1E502000078000277B6__37538.0967431285$1292276992$gmane$org@vpn.id2.novell.com>
References: <201012112329.35080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012112329.35080.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>>> On 11.12.10 at 23:29, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> The following commit:
> 
> http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h 
> =091aad6af4ab29af693ced5d6970ceee9d5981c8
> 
> (ACPI: eliminate unused variable warning for !ACPI_SLEEP)
> is actually wrong, because it's going to break compilation for
> (!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).

How would this break compilation in *any* configuration? The
variable definition got moved into an #ifdef the #else of which
has

#define acpi_target_sleep_state	ACPI_STATE_S0

Jan
