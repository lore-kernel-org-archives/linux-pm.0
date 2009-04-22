From: fanderay <fanderay4@googlemail.com>
Subject: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2
Date: Wed, 22 Apr 2009 13:55:15 +0100
Message-ID: <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904211521.31450.rjw@sisk.pl>
	<31c940650904210800l6934d1d9h350a1e9d7e3bd32e@mail.gmail.com>
	<200904212050.25531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904212050.25531.rjw@sisk.pl>
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

Hi Rafael,

I found the problem: it's the Sony laptop driver.  With
CONFIG_SONY_LAPTOP=y, the hard freeze on resume occurs.  Without this
driver in the kernel, resume after s2ram -f -p appears to work
correctly.
