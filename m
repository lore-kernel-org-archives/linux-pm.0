From: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 23:57:52 -0800
Message-ID: <20060219235752.2d6e252c.akpm@osdl.org>
References: <43F89F55.5070808@cfl.rr.com>
	<200602192144.57748.oliver@neukum.org>
	<20060219130243.52af0782.akpm@osdl.org>
	<200602200755.57699.oliver@neukum.org>
	<20060219232926.256665d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41459539374858645=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060219232926.256665d6.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: oliver@neukum.org, stern@rowland.harvard.edu, psusi@cfl.rr.com, pavel@suse.cz, torvalds@osdl.org, mrmacman_g4@mac.com, alon.barlev@gmail.com, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============41459539374858645==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Andrew Morton <akpm@osdl.org> wrote:
>
>  > If you simply block writes, the system will stall random tasks laundering
>  > pages, including those needed to make progress. Even syncing before
>  > suspend won't help you, as a running user space may dirty pages.
> 
>  Well of _course_ that will happen.

Actually, it won't happen.  There's already logic in there to help pdflush,
kswapd and memory-allocating tasks avoid blocking on congested queues. 
It's trivial to extend that to avoidance of hotunplugged queues.

Things like sync(), fsync(), O_SYNC and reads will necessarily block.

We may or may not decide to block on page-dirtyings.  Again, that's trivial
to do in balance_dirty_pages().

Race conditions are pretty much unavoidable - if someone goes and disables
a device when we're partway through and committed to I/O submission then
things will get very sticky.  But we can have a pretty successful solution
to all of this without a ton of effort.

But this is all the easy part.

--===============41459539374858645==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41459539374858645==--
