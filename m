From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Thu, 12 Feb 2009 11:31:26 +0000
Message-ID: <20090212113126.GC28176@srcf.ucam.org>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-2-git-send-email-arve@android.com>
	<1234316955-31304-3-git-send-email-arve@android.com>
	<1234316955-31304-4-git-send-email-arve@android.com>
	<1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-8-git-send-email-arve@android.com>
	<1234316955-31304-9-git-send-email-arve@android.com>
	<1234316955-31304-10-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1234316955-31304-10-git-send-email-arve@android.com>
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

On Tue, Feb 10, 2009 at 05:49:14PM -0800, Arve Hj=F8nnev=E5g wrote:

>  	spin_lock(&client->buffer_lock);
> +	wake_lock_timeout(&client->wake_lock, 5 * HZ);

Why the timeout version? If your input handler vanishes for more than 5 =

seconds then presumably you should be thinking about watchdoging the =

entire system.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
