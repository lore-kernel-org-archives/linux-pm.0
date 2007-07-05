From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 16:46:35 +0300
Message-ID: <1183643195.3619.21.camel@localhost.localdomain>
References: <67670A5CEA5C374B8E7B16D7DC55F9530124746A@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F9530124746A@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Thu, 2007-07-05 at 19:09 +0530, ext V, Sankara Narayanan wrote:
> I really can't stop the kernel from going to suspend using my master app
> (well, my app is not really a master app). It is just to inform the apps
> in the user space "Hey, I'm going to suspend, in the time available
> before I go to sleep, do whatever you can do!" whenever kernel goes to
> sleep. And I'm really can't stop the kernel from going to sleep (from a
> theoretical point I can do that as well, but at least I have not
> implemented that).

Yes, i've understood that.

What i'm saying is that your approach:

"Hey, I'm going to suspend, in the time available before I go to sleep,
do whatever you can do!"

is faulty, imo.


What we are doing in Maemo is:

App1 changes states -> App1 saves its state using library
App2 changes states -> App2 saves its state using library
App3 changes states -> App3 saves its state using library
App4 changes states -> App4 saves its state using library
....

Suspend event -> Apps do nothing 


Very simple and deterministic. Note also that you can track is Apps are
saving their state by refcounting and therefore delaying the actual
suspend command.

I hope that it's clear now.

cheers, igor

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
