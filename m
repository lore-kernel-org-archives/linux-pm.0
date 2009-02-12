From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 07/10] PM: earlysuspend: Add console switch
	when user requested sleep state changes.
Date: Thu, 12 Feb 2009 11:28:23 +0000
Message-ID: <20090212112823.GB28176@srcf.ucam.org>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-2-git-send-email-arve@android.com>
	<1234316955-31304-3-git-send-email-arve@android.com>
	<1234316955-31304-4-git-send-email-arve@android.com>
	<1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-8-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1234316955-31304-8-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 10, 2009 at 05:49:12PM -0800, Arve Hj=F8nnev=E5g wrote:
> When early-suspend is enabled, the framebuffer is turned off at
> early-suspend. If CONSOLE_EARLYSUSPEND is enabled, a console switch
> is used to notify user space that it should stop drawing before
> the framebuffer is disabled, and that it should repaint and resume
> drawing after the framebuffer is turned back on.

Mm. The console VT switching is an ugly hack to deal with the fact that =

in the x86 world graphics reinitialisation is handled by userspace, and =

so we otherwise have races between graphis reinitialisation and X. I =

don't think it's helpful to further perpetuate that hack, especially =

when you have another mechanism for requestng a screen refresh.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
