From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Tue, 11 Nov 2008 00:15:24 +0100
Message-ID: <20081110231524.GA18971__27830.7003587999$1226359077$gmane$org@mobydick>
References: <20081109195033.GA1335@mobydick>
	<20081110094239.GA14204@atrey.karlin.mff.cuni.cz>
	<20081110221343.GA17951@mobydick>
	<200811101506.53324.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811101506.53324.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

	Hello Jesse,

Thanks for the prompt reply.

On Mon, Nov 10, 2008 at 03:06:52PM -0800, Jesse Barnes wrote:
> If you have radeon loaded but DRI was never enabled, you'll likely see a 
> crash.  That's because the radeon driver doesn't map the registers it needs 
> for suspend/resume at load time; they only get mapped by DRI initialization 
> code which lives in the X driver.  There's a patch in 
> http://bugzilla.kernel.org/show_bug.cgi?id=11891 that might help you...

This one I guess:
http://bugzilla.kernel.org/attachment.cgi?id=18644&action=view

Let me give it a shot, I'll keep you posted.
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
