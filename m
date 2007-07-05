From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Power event notification patch
Date: Thu, 5 Jul 2007 14:51:34 +0200
Message-ID: <200707051451.34788.oliver@neukum.org>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247436@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F95301247436@bgsmsx413.gar.corp.intel.com>
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
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb V, Sankara Narayanan:
> Well, say I have two applications, say app1 and app2. App 1 initiates a
> suspend-to-RAM. How will app2 come to know the system is going to sleep.
> Only way is app1 needs to inform/broadcast that the application has
> initiates the sleep or the system is going to sleep. In that case, every
> application which initiates a sleep has to implement this. Quoting your

Yes, that is a situation that screams for implementation in a library.
Preferably through using multicast channels, like DBUS.

	Regards
		Oliver
