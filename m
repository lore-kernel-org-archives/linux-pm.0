From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 11:39:49 -0500
Message-ID: <43F89F55.5070808@cfl.rr.com>
References: <20060217210445.GR3490@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org>
	<20060218160242.7d2b5754.akpm@osdl.org>
	<43F80A06.2090209@cfl.rr.com>
	<20060218223221.6df891d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060218223221.6df891d3.akpm@osdl.org>
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
Cc: alon.barlev@gmail.com, torvalds@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, mrmacman_g4@mac.com
List-Id: linux-pm@vger.kernel.org

Andrew Morton wrote:
>>
>>  Hrm... interesting but sounds like that could be sticky.  For instance, 
>>  what if the user script that does the verifying happens to be ON the 
>>  volume to be verified?
> 
> Well that would be a bug.  Solutions would be a) don't put the scripts on a
> removable/power-downable device or b) use tmpfs.
> 

I don't see how it could be a bug, just think of the root on usb case. 
Keeping the program locked in ram would sidestep that issue, but tmpfs 
is pagable right?  Swap on usb?

Also, this user space program isn't going to be able to keep fully up to 
date on what the disk looks like.  Imagine a filesystem that keeps a 
generation counter in the super block and increments it every time it 
writes to the disk.  The user space daemon might read that, then the fs 
changes it, you suspend, and when you wake up, the daemon thinks the 
media changed because it wasn't fully up to date.
