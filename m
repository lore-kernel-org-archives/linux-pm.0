From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/9] PM / Hibernate: swap,
	switch to hibernate_io_handle
Date: Fri, 11 Jun 2010 19:46:04 +1000
Message-ID: <4C1205DC.1080200__47911.9994598024$1276249659$gmane$org@crca.org.au>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
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

Hi.

(Sorry Jiri - unintentionally originally replied only to you).

On 02/06/10 18:52, Jiri Slaby wrote:
 > Hi,
 >
 > I addressed the comments I got on the previous RFC. I left the handles
 > in place, the functions in hibernate_io_ops now works on them. Further
 > I got rid of the memory barriers and minimized global variables as much
 > as possible. Comments welcome.

I would like to hear the arguments for using these handles. I understand 
there may have been some previous discussion, but am unable to find it.

It seems far more sensible to me to not pass around a handle that 
virtually nothing actually uses, and instead store and utilise the state 
in the place where it is actually useful. If we had more than one struct 
hibernate_io_handle in use at a time, I could understand going this way. 
As it stands, however...

Regards,

Nigel
