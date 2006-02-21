From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] [pm] Minor updates to core
	suspend/resume functions
Date: Tue, 21 Feb 2006 04:42:44 -0800
Message-ID: <20060221044244.686df618.akpm@osdl.org>
References: <Pine.LNX.4.50.0602201653580.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70331450448874366=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602201653580.21145-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============70331450448874366==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Patrick Mochel <mochel@digitalimplant.org> wrote:
>
> - Check the real state the device and parent are in compared
>    to the the real state requested, instead of just checking
>    that the event types are the same.
> 
>  - Update debug and error messages to display the real states.

This patch causes resume failures here.  suspend-to-ram, resume and the
long-suffering USB wireless mouse is dead - the power light on the USB
gadget is off and nothing I can do will persuade it to come back on.


--===============70331450448874366==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70331450448874366==--
