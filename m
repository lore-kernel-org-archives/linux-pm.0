From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PM: fast power off - core
Date: Sat, 27 Jan 2007 12:08:21 -0800
Message-ID: <20070127120821.a631acd6.akpm@osdl.org>
References: <45BBA9D5.8020004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45BBA9D5.8020004@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: akuster <akuster@mvista.com>
Cc: linux-kernel-owner@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, 27 Jan 2007 09:36:53 -1000
akuster <akuster@mvista.com> wrote:

> Fastpoweroff  allows a user to power down the system without using rc kill
> scripts. =


Confused.  I just type `halt -pfn'.  Why is this patch better?
