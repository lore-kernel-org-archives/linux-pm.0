From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/9] PM / Hibernate: user,
	implement user_ops reader
Date: Fri, 25 Jun 2010 15:37:06 +0200
Message-ID: <201006251537.06601.rjw__40781.9855878644$1277473157$gmane$org@sisk.pl>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<1275468768-28229-4-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-4-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 02, 2010, Jiri Slaby wrote:
> Switch /dev/snapshot writer to hibernate_io_ops approach so that we
> can do whatever we want with snapshot processing code. All the later
> code changes will be transparent and needn't care about different
> readers/writers.
> 
> In this patch only reader is implemented, writer was done previously.
> 
> It works similarly to writer, CONSUMER here is snapshot layer,
> PRODUCER is fops->write.

Here, I have pretty much the same comment as for [3/9].  I don't really think
it's necessary or even useful to change the s2disk code paths.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---

Rafael
