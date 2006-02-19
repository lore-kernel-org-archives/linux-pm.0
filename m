From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 21:44:57 +0100
Message-ID: <200602192144.57748.oliver@neukum.org>
References: <43F89F55.5070808@cfl.rr.com>
	<Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
	<20060219120221.1d11cee0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060219120221.1d11cee0.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: alon.barlev@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, psusi@cfl.rr.com, torvalds@osdl.org, mrmacman_g4@mac.com
List-Id: linux-pm@vger.kernel.org

Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> For a), the current kernel behaviour is what we want - make the thing
> appear at a new place in the namespace and in the hierarchy. =A0Then
> userspace can do whatever needs to be done to identify the device, and
> apply some sort of policy decision to the result.

How? If you have a running user space the connection to the open files
is already severed, as any access in that time window must fail.
For the rest we have udev.

	Oliver
