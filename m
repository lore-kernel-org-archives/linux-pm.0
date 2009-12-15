From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Mon, 14 Dec 2009 16:19:22 -0800
Message-ID: <20091214161922.6f252492__14931.1050925919$1260836276$gmane$org@infradead.org>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2009 15:11:47 -0800
Salman Qazi <sqazi@google.com> wrote:


I like the general idea, I have one request (that I didn't see quite in
your explanation): Please make sure that all cpus in the system do
their idle injection at the same time, so that memory can go into power
saving mode as well during this time etc etc...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
