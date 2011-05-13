From: Davide Ciminaghi <ciminaghi@gnudd.com>
Subject: Re: [PATCH 1/4] export bus_kset
Date: Fri, 13 May 2011 19:11:48 +0200
Message-ID: <20110513171148.GM29259__42302.0380003892$1305306769$gmane$org@mail.gnudd.com>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<1305220265-9020-2-git-send-email-lamiaposta71@gmail.com>
	<201105122128.54172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105122128.54172.rjw@sisk.pl>
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

On Thu, May 12, 2011 at 09:28:53PM +0200, Rafael J. Wysocki wrote:

hi,

sorry, I missed this message this morning.

> On Thursday, May 12, 2011, Raffaele Recalcati wrote:
> > From: Davide Ciminaghi <ciminaghi@gnudd.com>
> 
> Please explain why you need to export it, what the alternatives are and
> why you think this approach is better than the alternatives.
> 

what I needed to do was walking through the list of registered busses,
and invoking the bus_added()/bus_removed() callback of a newly registered
policy. I couldn't find any other simple way to do it.

Regards
Davide
