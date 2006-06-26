From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: How to differentiate between selective suspend and
 global suspend
Date: Mon, 26 Jun 2006 10:34:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606261033250.9506-100000@iolanthe.rowland.org>
References: <380D9721A8E2114485644D71E87C6AB20214DC0B@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20214DC0B@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Jun 2006 rasmit.ranjan@wipro.com wrote:

> Hi,
>     I have implemented bus_suspend entry point of hc_driver of my OHCI
> complaint host controller. This entry point is called when i do
> selective roothub interface suspend as well as when i do global suspend
> ( suspend to disk ). So is there any way to differentiate between
> selective suspend of roothub interface and global suspend ( suspend to
> disk ) for both of which my bus_suspend entry point is getting called ?

No.

Alan Stern
