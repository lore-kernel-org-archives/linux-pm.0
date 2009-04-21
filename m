From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2
Date: Tue, 21 Apr 2009 20:25:09 +0200
Message-ID: <200904212025.10184.rjw@sisk.pl>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904211521.31450.rjw@sisk.pl>
	<31c940650904210800l6934d1d9h350a1e9d7e3bd32e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <31c940650904210800l6934d1d9h350a1e9d7e3bd32e@mail.gmail.com>
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
To: fanderay <fanderay4@googlemail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 April 2009, fanderay wrote:
> On Tue, Apr 21, 2009 at 2:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > Please try if booting with acpi_sleep=old_ordering changes anything.
> 
> Thanks, I tried various permutations of s2ram options together with
> the acpi_sleep=old_ordering kernel option, but this did not change the
> behavior at all.  I can also now confirm that resume after s2ram -f -p
> works with the stock Debian 2.6.29 kernel.  So either the problem
> appeared between .29 and .30rc2, or it's being tickled by something in
> my kernel config (posted earlier).

Well, unfortunately both are possible.  You can use scripts/diffconfig (in the
kernel source tree) to check differences between your configuration and the
debian one (if available).

Thanks,
Rafael
