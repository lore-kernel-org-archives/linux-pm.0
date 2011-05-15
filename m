From: Davide Ciminaghi <ciminaghi@gnudd.com>
Subject: Re: [PATCH 1/4] export bus_kset
Date: Sun, 15 May 2011 16:13:07 +0200
Message-ID: <20110515141307.GC15994__26863.7385023341$1305468927$gmane$org@mail.gnudd.com>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<1305220265-9020-2-git-send-email-lamiaposta71@gmail.com>
	<201105122128.54172.rjw@sisk.pl>
	<20110513171148.GM29259@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110513171148.GM29259@mail.gnudd.com>
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
Cc: linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, Raffaele Recalcati <lamiaposta71@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 13, 2011 at 07:11:48PM +0200, Davide Ciminaghi wrote:
> On Thu, May 12, 2011 at 09:28:53PM +0200, Rafael J. Wysocki wrote:
> 
> hi,
> 
> sorry, I missed this message this morning.
> 
> > On Thursday, May 12, 2011, Raffaele Recalcati wrote:
> > > From: Davide Ciminaghi <ciminaghi@gnudd.com>
> > 
> > Please explain why you need to export it, what the alternatives are and
> > why you think this approach is better than the alternatives.
> > 
> 
> what I needed to do was walking through the list of registered busses,
> and invoking the bus_added()/bus_removed() callback of a newly registered
> policy. I couldn't find any other simple way to do it.
>
well, I there is another way to do that: adding a function like this
(include/linux/device.h) :

/**
 * run a callback for each registered bus type
 *
 * @data : arg passed to callback
 * @fn : pointer to callback
 */
int for_each_bus(void *data, int (*fn)(struct bus_type *bus, void *data));

which would be similar to the already existing bus_for_each_dev() and
would allow to avoid exporting a global variable.


Regards
Davide
