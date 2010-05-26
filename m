From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 18:59:19 +0200
Message-ID: <20100526165919.GB2089__20772.1240156845$1274893300$gmane$org@elf.ucw.cz>
References: <1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
	<AANLkTik9LINPmabJfVi0jfVs5sjVS_1l00WpnVTFEuLV@mail.gmail.com>
	<1274890736.4467.574.camel@mulgrave.site>
	<1274891308.1674.1766.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274891308.1674.1766.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Pekka Enberg <penberg@cs.helsinki.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2010-05-26 18:28:28, Peter Zijlstra wrote:
> On Wed, 2010-05-26 at 11:18 -0500, James Bottomley wrote:
> > > Or make the suspend manager a C proglet and provide a JNI interface,
> > > or whatever.
> > 
> > It's a fairly large piece of code to try to rewrite in C, so I don't
> > think that's feasible on a reasonable timescale.  Android does have the
> > concept of special sockets that can be used to communicate from less to
> > more privileged processes (it has a very segmented runtime model), so
> > these might be usable ... they have a drawback that they're essentially
> > named pipes, so no multiplexing, but one per suspend influencing C
> > process shouldn't be a huge burden. 
> 
> It wouldn't need to convert the whole Frameworks layer into C, just
> enough to manage the suspend state.
> 
> Anyway, I think there's been enough arguments against even the concept
> of opportunistic/auto-suspend, and I for one will object with a NAK if
> Rafael send this to Linus.

It was submitted already. I tried to followup with NAK, but can't
currently see it in the archive.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
