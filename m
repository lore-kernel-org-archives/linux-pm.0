From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 4 Jan 2008 17:52:14 +0100
Message-ID: <20080104165214.GA30672__33441.2204371349$1199466968$gmane$org@dspnet.fr.eu.org>
References: <20080104160933.B01D81FBAB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<Pine.LNX.4.44L0.0801041136490.4078-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0801041136490.4078-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: yi.y.yang@intel.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 04, 2008 at 11:38:29AM -0500, Alan Stern wrote:
> How about changing it to say "unavailable"?  That doesn't imply 
> permanence.

How about not changing a userland-visible interface gratuitously?

  OG.
