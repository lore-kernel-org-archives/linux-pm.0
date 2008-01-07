From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Sun, 6 Jan 2008 19:49:43 -0800
Message-ID: <200801061949.44408.david-b__31000.162222381$1199677871$gmane$org@pacbell.net>
References: <20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080104165214.GA30672@dspnet.fr.eu.org>
	<1199670923.3551.10.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199670923.3551.10.camel@yangyi-dev.bj.intel.com>
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
To: yi.y.yang@intel.com
Cc: linux-pm@lists.linux-foundation.org, Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 06 January 2008, Yi Yang wrote:
> 
> > How about not changing a userland-visible interface gratuitously?
>
> "empty" can't tell a user the state of wakeup of a device, so it is
> necessary to change it.

Words don't say anything at all in isolation.  For example,
here the current tristate behavior has been documented for
several years now ... and that's the only thing that could
have conveyed any meaning whatever.

I can't agree that it's even slightly "necessary" to make
such a grutuitous and backwards-incompatible change.
