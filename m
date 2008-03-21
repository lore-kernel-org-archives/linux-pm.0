From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Proper way to invoke suspend?
Date: Fri, 21 Mar 2008 22:05:09 +0100
Message-ID: <200803212205.10327.rjw__4034.76140131733$1206133639$gmane$org@sisk.pl>
References: <20080321203040.99655491.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080321203040.99655491.Kristoffer.Ericson@Gmail.com>
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
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-main <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 22 of March 2008, Kristoffer Ericson wrote:
> Rafael,

Hi,

> Been looking around for examples, but obviously something I don't understand. 
> Currently I set apm_queue_event(APM_USER_SUSPEND) inside the power button interrupt, this does nothing.
> 
> However if I cat the state, it goes into suspend. Resume fails but thats another question.

Well, I have a little experience with APM.  If you told me some more details
about what you're after, that would be helpful.

Thanks,
Rafael
