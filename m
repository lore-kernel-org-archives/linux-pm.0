From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Status of Regression/Bug 13407 adb trackpad
	disappears after suspend to ram?
Date: Sun, 27 Sep 2009 17:13:44 +0200
Message-ID: <200909271713.44719.rjw@sisk.pl>
References: <4ABF5432.9020508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4ABF5432.9020508@gmx.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Wache <m.wache@gmx.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 27 September 2009, Martin Wache wrote:
> Hi all,
> 
> I'd like to ask if there is any news on the bug 13407
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13407
> 
> The status of the bugreport is "NEEDINFO", I'm also hit by this bug, 
> using 2.6.31 on an iBook G4. Can I help in anyway to get this bug fixed? 
> I'm happy to provide any info I can, if there is need for more info. I 
> would also try patches if that helps.

A patch has been submitted which is reported to fix the issue:

http://patchwork.kernel.org/patch/49462/

Please test it as requested.

Best,
Rafael
