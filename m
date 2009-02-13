From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Fri, 13 Feb 2009 00:40:54 +0000
Message-ID: <20090213004054.GB8454@srcf.ucam.org>
References: <1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-8-git-send-email-arve@android.com>
	<1234316955-31304-9-git-send-email-arve@android.com>
	<1234316955-31304-10-git-send-email-arve@android.com>
	<20090212113126.GC28176@srcf.ucam.org>
	<d6200be20902121627k7ea21f21hba24a2616e27aa42@mail.gmail.com>
	<20090213003402.GA8393@srcf.ucam.org>
	<d6200be20902121638t62687ec6k6fc39055a41a78fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902121638t62687ec6k6fc39055a41a78fa@mail.gmail.com>
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

On Thu, Feb 12, 2009 at 04:38:27PM -0800, Arve Hj=F8nnev=E5g wrote:

> I can make it a module param. I still need a default. I considering 0
> (no wakelock), 5 seconds or infinite.

I'm not clear on this. Why do you need a default? Just fix your =

userspace to reboot the system if the input consumer stops responding =

and won't restart. Your system is entirely fucked at that point anyway.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
