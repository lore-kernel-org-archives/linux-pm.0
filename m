From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/18] x86 idle APM: deprecate
	CONFIG_APM_CPU_IDLE
Date: Fri, 8 Apr 2011 08:22:25 +0200
Message-ID: <20110408062225.GA1596__30539.5594252788$1302243983$gmane$org@ucw.cz>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<392e1ffeeaefd448f69d45041fe4406fbd197852.1301724243.git.len.brown@intel.com>
	<20110402122810.1371afa8@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1104021427040.18682@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1104021427040.18682@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat 2011-04-02 14:28:31, Len Brown wrote:
> > Give it a year, it doesn't cause any complexities I can see.
> 
> I'd rather not create a new an APM cpuilde driver,
> since there is nobody volunteering to test it.
> If you have the time and the hardware, please speak up.

I'm willing to test is, as is Jiri Kosina AFAICT.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
