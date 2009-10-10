From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] PM / Hibernate: swap, use KERN_CONT
Date: Sat, 10 Oct 2009 14:19:25 +0200
Message-ID: <4AD07BCD.1000902@gmail.com>
References: <1255176024-12420-1-git-send-email-jirislaby@gmail.com>
	<20091010121504.GB1943@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091010121504.GB1943@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/10/2009 02:15 PM, Pavel Machek wrote:
> On Sat 2009-10-10 14:00:24, Jiri Slaby wrote:
>> Use KERN_CONT in save_image for printks. So that anybody won't
>> try to add a loglevel.
> 
> Someone has a big, pending patch to switch to pr_*. Should we take
> that instead?

I have no problem with that at all.
