From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 16:20:58 +0300
Message-ID: <1183641658.3619.14.camel@localhost.localdomain>
References: <67670A5CEA5C374B8E7B16D7DC55F9530124744C@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F9530124744C@bgsmsx413.gar.corp.intel.com>
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

On Thu, 2007-07-05 at 18:39 +0530, ext V, Sankara Narayanan wrote:
> Guys,
> 
> You really can't depend on this if your application want to execute some
> 10000 lines of code. What I told is the app will have enough time to do
> some minimal work (say wanna do some cleanup which is of the order of
> 100 instructions or so). The go-to-suspend time is of the order of 2.x
> seconds. So, we can really do it.
> 
> Igor,
> I really do not understand what you mean by NACK (is it No ACK? If yes,
> please explain)

You are not expecting another app (say app2) to veto (No ACK) what your
master app (app1) has decided.

You only want app 2 to take care of itself so that its internal state
(the part you care about) will be available for restoring, should something
go bad. That, btw, is the same situation as with the OOM killer.


Your assumption to do something when the system starts to go in suspended
mode is dangerous and, as i said, not really safe.

Instead, if you save your application state when it changes (i.e. the user
opens a new tab in the browser) you will be able to restore the application
state in _any_ case, not just for a failed suspend.

It's cleaner, deterministic and doesn't introduce artificial dependencies
on kernelspace.
Keep also in mind that your numbers are probably bogus on different
architectures and your solution might not work (yes, i've seen your email
address but that doesn't justify the creation of arch-specific coded when
it's not necessary ;-)

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
