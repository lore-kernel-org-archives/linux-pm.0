From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Power management for individual devices
Date: Mon, 18 Aug 2008 12:06:05 +0200
Message-ID: <200808181206.05489.rjw@sisk.pl>
References: <8ab0f6a80808180133w1d2a026eqe936eda67fc51e72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8ab0f6a80808180133w1d2a026eqe936eda67fc51e72@mail.gmail.com>
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
To: Jayanthi Annadurai <jayanti.a@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 18 of August 2008, Jayanthi Annadurai wrote:
> Hello,

Hi,

> We are doing development on a MIPS based chip with linux 2.6.24 kernel.
> We want to suspend a device when it is not used. The attribute
> /sys/devices/platform/../power/state has been removed. What is the
> replacement of this?
> What is the user interface to do the same?

There's no replacement at the moment, because we have no infrastructure
for this kind of functionality.

There is a plan to introduce such a infrastructure in future, but that rather
won't happen any time soon.

Thanks,
Rafael
