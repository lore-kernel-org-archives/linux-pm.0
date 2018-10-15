From: Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 4.20-rc1
Date: Mon, 15 Oct 2018 13:21:42 -0600
Message-ID: <88f95364-29a8-358e-356e-e62771e52c8e@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E7C80CE968FD9FC61062210A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7C80CE968FD9FC61062210A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 4.20-rc1

This cpupower update for Linux 4.20-rc1 consists of fixes for bugs and
compile warnings from Prarit Bhargava and Anders Roxell.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.20-rc1

for you to fetch changes up to f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6:

  cpupower: Fix coredump on VMWare (2018-10-08 09:19:15 -0600)

----------------------------------------------------------------
linux-cpupower-4.20-rc1

This cpupower update for Linux 4.20-rc1 consists of fixes for bugs and
compile warnings from Prarit Bhargava and Anders Roxell.

----------------------------------------------------------------
Anders Roxell (1):
      cpupower: remove stringop-truncation waring

Prarit Bhargava (2):
      cpupower: Fix AMD Family 0x17 msr_pstate size
      cpupower: Fix coredump on VMWare

 tools/power/cpupower/bench/parse.c        | 2 +-
 tools/power/cpupower/utils/cpufreq-info.c | 2 ++
 tools/power/cpupower/utils/helpers/amd.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------E7C80CE968FD9FC61062210A
Content-Type: text/plain; charset=UTF-8;
 name="linux-cpupower-4.20-rc1.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-cpupower-4.20-rc1.txt"

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1YjM5NGIyZGRmMDM0N2JlZjU2
ZTUwYzY5YTU4NzczYzk0MzQzZmYzOgoKICBMaW51eCA0LjE5LXJjMSAoMjAxOC0wOC0yNiAx
NDoxMTo1OSAtMDcwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
OgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2h1
YWgvbGludXggdGFncy9saW51eC1jcHVwb3dlci00LjIwLXJjMQoKZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIGY2OWZmYzVkM2RiOGYxZjAzZmQ2ZDFkZjU5MzBmOWExZmJkNzg3
YjY6CgogIGNwdXBvd2VyOiBGaXggY29yZWR1bXAgb24gVk1XYXJlICgyMDE4LTEwLTA4IDA5
OjE5OjE1IC0wNjAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpsaW51eC1jcHVwb3dlci00LjIwLXJjMQoKVGhp
cyBjcHVwb3dlciB1cGRhdGUgZm9yIExpbnV4IDQuMjAtcmMxIGNvbnNpc3RzIG9mIGZpeGVz
IGZvciBidWdzIGFuZApjb21waWxlIHdhcm5pbmdzIGZyb20gUHJhcml0IEJoYXJnYXZhIGFu
ZCBBbmRlcnMgUm94ZWxsLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbmRlcnMgUm94ZWxsICgxKToKICAgICAg
Y3B1cG93ZXI6IHJlbW92ZSBzdHJpbmdvcC10cnVuY2F0aW9uIHdhcmluZwoKUHJhcml0IEJo
YXJnYXZhICgyKToKICAgICAgY3B1cG93ZXI6IEZpeCBBTUQgRmFtaWx5IDB4MTcgbXNyX3Bz
dGF0ZSBzaXplCiAgICAgIGNwdXBvd2VyOiBGaXggY29yZWR1bXAgb24gVk1XYXJlCgogdG9v
bHMvcG93ZXIvY3B1cG93ZXIvYmVuY2gvcGFyc2UuYyAgICAgICAgfCAyICstCiB0b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYyB8IDIgKysKIHRvb2xzL3Bvd2Vy
L2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvYW1kLmMgIHwgNyArKysrKystCiAzIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
--------------E7C80CE968FD9FC61062210A--
