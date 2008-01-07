From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Mon, 07 Jan 2008 09:55:23 +0800
Message-ID: <1199670923.3551.10.camel__36032.2687229656$1199671350$gmane$org@yangyi-dev.bj.intel.com>
References: <20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<Pine.LNX.4.44L0.0801041136490.4078-100000@iolanthe.rowland.org>
	<20080104165214.GA30672@dspnet.fr.eu.org>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080104165214.GA30672@dspnet.fr.eu.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-01-04 at 17:52 +0100, Olivier Galibert wrote:
> On Fri, Jan 04, 2008 at 11:38:29AM -0500, Alan Stern wrote:
> > How about changing it to say "unavailable"?  That doesn't imply 
> > permanence.
> 
> How about not changing a userland-visible interface gratuitously?
"empty" can't tell a user the state of wakeup of a device, so it is
necessary to change it.
> 
>   OG.
> 
