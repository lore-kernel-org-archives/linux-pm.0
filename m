From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v5 0/6] notifier error injection
Date: Tue, 3 Jul 2012 13:41:20 -0700
Message-ID: <20120703134120.dc89c7ae.akpm@linux-foundation.org>
References: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Sat, 30 Jun 2012 14:59:24 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This provides kernel modules that can be used to test the error handling
> of notifier call chain failures by injecting artifical errors to the
> following notifier chain callbacks.

No updates to Documentation/fault-injection/?
