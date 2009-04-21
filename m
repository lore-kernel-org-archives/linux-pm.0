From: fanderay <fanderay4@googlemail.com>
Subject: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2
Date: Tue, 21 Apr 2009 16:00:46 +0100
Message-ID: <31c940650904210800l6934d1d9h350a1e9d7e3bd32e@mail.gmail.com>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904202253.54768.rjw@sisk.pl>
	<31c940650904201511l45e32bfbn8c30955c7b81962d@mail.gmail.com>
	<200904211521.31450.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904211521.31450.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 21, 2009 at 2:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Please try if booting with acpi_sleep=old_ordering changes anything.

Thanks, I tried various permutations of s2ram options together with
the acpi_sleep=old_ordering kernel option, but this did not change the
behavior at all.  I can also now confirm that resume after s2ram -f -p
works with the stock Debian 2.6.29 kernel.  So either the problem
appeared between .29 and .30rc2, or it's being tickled by something in
my kernel config (posted earlier).
