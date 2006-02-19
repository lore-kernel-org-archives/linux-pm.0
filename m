From: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sat, 18 Feb 2006 22:32:21 -0800
Message-ID: <20060218223221.6df891d3.akpm@osdl.org>
References: <20060217210445.GR3490@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org>
	<20060218160242.7d2b5754.akpm@osdl.org>
	<43F80A06.2090209@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45470115093173524=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43F80A06.2090209@cfl.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: alon.barlev@gmail.com, torvalds@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, mrmacman_g4@mac.com
List-Id: linux-pm@vger.kernel.org

--===============45470115093173524==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Phillip Susi <psusi@cfl.rr.com> wrote:
>
> > But I suspect we could do an even better job if we did that in userspace.
>  > 
>  > The logic to determine whether the new device is the same as the old device
>  > can be arbitrarily complex, with increasing levels of success.  Various
>  > heuristics can be applied, some of which will involve knowledge of
>  > filesystem layout, etc.
>  > 
>  > So would it not be possible to optionally punt the device naming decision
>  > up to the hotplug scripts?  So code up there can go do direct-IO reads of
>  > the newly-present blockdev, use filesytem layout knowledge, peek at UUIDs,
>  > superblocks, disk labels, partition tables, inode numbering, etc?  Go look
>  > up a database, work out what that filesystem was doing last time we saw it,
>  > etc?
>  > 
>  > We could of course add things to the filesystems to help this process, but
>  > it'd be good if all the state tracking and magic didn't have to be locked
>  > up in the kernel.
> 
> 
>  Hrm... interesting but sounds like that could be sticky.  For instance, 
>  what if the user script that does the verifying happens to be ON the 
>  volume to be verified?

Well that would be a bug.  Solutions would be a) don't put the scripts on a
removable/power-downable device or b) use tmpfs.

--===============45470115093173524==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45470115093173524==--
