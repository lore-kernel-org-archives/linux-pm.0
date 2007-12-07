From: Pavel Machek <pavel@ucw.cz>
Subject: Re: parallel suspend/resume
Date: Fri, 7 Dec 2007 15:51:23 +0000
Message-ID: <20071207155122.GA4252@ucw.cz>
References: <20071008194639.GA5301@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071008194639.GA5301@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2007-10-08 15:46:39, Marcelo Tosatti wrote:
> Hi,
> 
> I spent some time working with the parallel suspend/resume idea, even
> wrote a simple patch (attached), but that obviously does not scale to
> large number of devices.
> 
> What would be a better approach? 

No idea, but thread per device does not seem _that_ bad. Debuggability
worries me more.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
