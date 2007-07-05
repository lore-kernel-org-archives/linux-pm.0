From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: RE: Power event notification patch
Date: Thu, 5 Jul 2007 18:47:57 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F95301247453@bgsmsx413.gar.corp.intel.com>
References: <1183641177.3818.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1183641177.3818.40.camel@johannes.berg>
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

We have to confirm that. And even if that does, running just linux
kernel as OS without these applications/libraries does not guarantee the
power notification. It means that I have to run these apps/libraries
wherever I want power event notification (example embedded devices).

Thanks,
Sankar.

-----Original Message-----
From: Johannes Berg [mailto:johannes@sipsolutions.net] 
Sent: Thursday, July 05, 2007 6:43 PM
To: V, Sankara Narayanan
Cc: Igor Stoppa; Oliver Neukum; linux-pm@lists.linux-foundation.org
Subject: RE: [linux-pm] Power event notification patch

On Thu, 2007-07-05 at 18:39 +0530, V, Sankara Narayanan wrote:

> Johannes,
> In that case, you need to implement it in every power manager and in
> turn HAL and DBUS get these from the kernel, one more redirection
which
> will further reduce the time for the app to do the 'minimal' work.

No, as far as I know it'll actually tell applications *before* telling
the kernel.

johannes
