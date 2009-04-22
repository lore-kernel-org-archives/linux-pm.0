From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] sony-laptop breaks resume from S2RAM (was:
	Re: Resume after suspend-to-ram broken for Vaio SR19VN in 30rc2)
Date: Wed, 22 Apr 2009 22:02:23 +0200
Message-ID: <200904222202.24271.rjw__27163.4758370512$1240430813$gmane$org@sisk.pl>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904212050.25531.rjw@sisk.pl>
	<31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Mattia Dongili <malattia@linux.it>
List-Id: linux-pm@vger.kernel.org

On Wednesday 22 April 2009, fanderay wrote:
> Hi Rafael,
> 
> I found the problem: it's the Sony laptop driver.  With
> CONFIG_SONY_LAPTOP=y, the hard freeze on resume occurs.  Without this
> driver in the kernel, resume after s2ram -f -p appears to work
> correctly.

It seems to be an ACPI problem, then.  Added some CCs.

Thanks,
Rafael
