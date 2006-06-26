From: David Brownell <david-b@pacbell.net>
Subject: Re: How to differentiate between selective suspend and
	global suspend
Date: Mon, 26 Jun 2006 09:58:14 -0700
Message-ID: <200606260958.15104.david-b@pacbell.net>
References: <380D9721A8E2114485644D71E87C6AB20214DC0B@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20214DC0B@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: rasmit.ranjan@wipro.com
List-Id: linux-pm@vger.kernel.org

On Sunday 25 June 2006 10:03 pm, rasmit.ranjan@wipro.com wrote:
> 	 So is there any way to differentiate between
> selective suspend of roothub interface and global suspend ( suspend to
> disk ) for both of which my bus_suspend entry point is getting called ?

Suspend-to-Disk is a system state, not a driver state;
you seem confused about things.

There is no distinction between suspending the root hub and
suspending all its downstream ports; how could you do one
without the other???
