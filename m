From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: RE: Power event notification patch
Date: Thu, 5 Jul 2007 19:03:43 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F95301247460@bgsmsx413.gar.corp.intel.com>
References: <1183642080.3818.46.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1183642080.3818.46.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Yeah! If it is a pseudo-embedded device, it can take care of because the
application ecosystem is already established there. It won't be a
generic thing for all embedded devices. Of course, every application
receives the event and it can act on the way it wants (I did not
understand step 1/2/3...). 

Thanks,
Sankar.

-----Original Message-----
From: Johannes Berg [mailto:johannes@sipsolutions.net] 
Sent: Thursday, July 05, 2007 6:58 PM
To: V, Sankara Narayanan
Cc: Igor Stoppa; Oliver Neukum; linux-pm@lists.linux-foundation.org
Subject: RE: [linux-pm] Power event notification patch

On Thu, 2007-07-05 at 18:47 +0530, V, Sankara Narayanan wrote:
> We have to confirm that. And even if that does, running just linux
> kernel as OS without these applications/libraries does not guarantee
the
> power notification. 

True.

> It means that I have to run these apps/libraries
> wherever I want power event notification (example embedded devices).

Well, if you have a truly embedded device then likely you don't care
about this at all since the applications will work together much closer
than on a desktop system. Also, you likely have much stricter
requirements in that each application *must* be able to do exactly steps
1/2/3 before the system is suspended. Also, suspend will likely be
*much* faster too.

If it's pseudo-embedded like Nokia's N770/800 then you can very well run
things like hal to handle it.

johannes
