From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Power event notification patch
Date: Thu, 5 Jul 2007 14:34:47 +0200
Message-ID: <200707051434.47970.oliver@neukum.org>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247414@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F95301247414@bgsmsx413.gar.corp.intel.com>
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
> 1. Isn't it the kernel which is finally initiating a low power sleep
> state? So, I added it in kernel/power/main.c where the kernel does all
> the suspend related activities.

Not really. The kernel takes the system to sleep if somebody with
the proper credentials tells it to do so. The kernel doesn't take the
initiative.

So the most obvious place to do the notification is with the entity
that initiates the sleep.

> 2. To answer your second question, we really can't guarantee. But even
> if you take Windows Vista (sorry linux enthusiasts for referring windows
> here) or any other non-UNIX operating systems (which has this power
> event notification), they really do not guarantee it. But, it is an
> era-of-tera and the user space applications can do some minimal work
> like saving the app's last state in a .tmp file or so (like firefox if
> closed in an unclean way) to restore their state.

Well, we want to better than that other OS.

If you do this in user space, eg. the pm utilities, you can easily implement
policies like waiting x seconds for the rest of the system to respond.

	Regards
		Oliver
